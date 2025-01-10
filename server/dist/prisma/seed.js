"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = require("@prisma/client");
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const prisma = new client_1.PrismaClient();
function deleteAllData(orderedFileNames) {
    return __awaiter(this, void 0, void 0, function* () {
        const modelNames = orderedFileNames.map((fileName) => {
            const modelName = path_1.default.basename(fileName, path_1.default.extname(fileName));
            return modelName.charAt(0).toUpperCase() + modelName.slice(1);
        });
        for (const modelName of modelNames) {
            const model = prisma[modelName];
            if (model) {
                yield model.deleteMany({});
                console.log(`Cleared data from ${modelName}`);
            }
            else {
                console.error(`Model ${modelName} not found. Please ensure the model name is correctly specified.`);
            }
        }
    });
}
function main() {
    return __awaiter(this, void 0, void 0, function* () {
        const dataDirectory = path_1.default.join(__dirname, "seedData");
        const orderedFileNames = [
            "products.json",
            "expenseSummary.json",
            "sales.json",
            "salesSummary.json",
            "purchases.json",
            "purchaseSummary.json",
            "users.json",
            "expenses.json",
            "expenseByCategory.json",
        ];
        yield deleteAllData(orderedFileNames);
        // for (const fileName of orderedFileNames) {
        //   const filePath = path.join(dataDirectory, fileName);
        //   const jsonData = JSON.parse(fs.readFileSync(filePath, "utf-8"));
        //   const modelName = path.basename(fileName, path.extname(fileName));
        //   const model: any = prisma[modelName as keyof typeof prisma];
        //   if (!model) {
        //     console.error(`No Prisma model matches the file name: ${fileName}`);
        //     continue;
        //   }
        //   for (const data of jsonData) {
        //     await model.create({
        //       data,
        //     });
        //   }
        //   console.log(`Seeded ${modelName} with data from ${fileName}`);
        // }
        for (const fileName of orderedFileNames) {
            const filePath = path_1.default.join(dataDirectory, fileName);
            if (!fs_1.default.existsSync(filePath)) {
                console.error(`File not found: ${filePath}`);
                continue;
            }
            const fileContent = fs_1.default.readFileSync(filePath, "utf-8");
            const jsonData = JSON.parse(fileContent);
            const modelName = path_1.default.basename(fileName, ".json");
            const model = prisma[modelName];
            if (!model) {
                console.error(`No matching Prisma model for: ${modelName}`);
                continue;
            }
            for (const item of jsonData) {
                try {
                    // Convert BigInt strings to BigInt for relevant fields
                    if (modelName === 'expenses' || modelName === 'expenseByCategory') {
                        if (item.amount) {
                            item.amount = BigInt(item.amount);
                        }
                    }
                    yield model.create({
                        data: item
                    });
                }
                catch (error) {
                    console.error(`Error seeding ${modelName}:`, error);
                    console.error('Problematic data:', item);
                }
            }
            console.log(`Successfully seeded ${modelName}`);
        }
    });
}
main()
    .catch((e) => {
    console.error(e);
})
    .finally(() => __awaiter(void 0, void 0, void 0, function* () {
    yield prisma.$disconnect();
}));
