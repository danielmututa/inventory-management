/*
  Warnings:

  - You are about to drop the column `changedpercentage` on the `PurchaseSummary` table. All the data in the column will be lost.
  - You are about to drop the column `unitprice` on the `Sales` table. All the data in the column will be lost.
  - You are about to drop the column `changedpercentage` on the `SalesSummary` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the `purchases` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[userName]` on the table `Users` will be added. If there are existing duplicate values, this will fail.
  - Made the column `totalExpenses` on table `ExpenseSummary` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `totalAmount` to the `Sales` table without a default value. This is not possible if the table is not empty.
  - Added the required column `unitPrice` to the `Sales` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userName` to the `Users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "purchases" DROP CONSTRAINT "purchases_productId_fkey";

-- AlterTable
ALTER TABLE "ExpenseSummary" ALTER COLUMN "totalExpenses" SET NOT NULL;

-- AlterTable
ALTER TABLE "Expenses" ALTER COLUMN "amount" SET DATA TYPE DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "PurchaseSummary" DROP COLUMN "changedpercentage",
ADD COLUMN     "changePercentage" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Sales" DROP COLUMN "unitprice",
ADD COLUMN     "totalAmount" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "unitPrice" DOUBLE PRECISION NOT NULL;

-- AlterTable
ALTER TABLE "SalesSummary" DROP COLUMN "changedpercentage",
ADD COLUMN     "changePercentage" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Users" DROP COLUMN "name",
ADD COLUMN     "addCountry" TEXT,
ADD COLUMN     "addrCity" TEXT,
ADD COLUMN     "addrDesc" TEXT,
ADD COLUMN     "addrNumber" TEXT,
ADD COLUMN     "addrZip" TEXT,
ADD COLUMN     "avatar" TEXT,
ADD COLUMN     "bio" TEXT,
ADD COLUMN     "cover" TEXT,
ADD COLUMN     "dateOfBirth" TIMESTAMP(3),
ADD COLUMN     "firstName" TEXT,
ADD COLUMN     "isAdmin" BOOLEAN,
ADD COLUMN     "lastName" TEXT,
ADD COLUMN     "password" TEXT,
ADD COLUMN     "phoneNumber" TEXT,
ADD COLUMN     "taxId" TEXT,
ADD COLUMN     "userName" TEXT NOT NULL,
ADD COLUMN     "web3Wallet" TEXT;

-- DropTable
DROP TABLE "purchases";

-- CreateTable
CREATE TABLE "Purchases" (
    "purchaseId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unitCost" DOUBLE PRECISION NOT NULL,
    "totalCost" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Purchases_pkey" PRIMARY KEY ("purchaseId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_userName_key" ON "Users"("userName");

-- AddForeignKey
ALTER TABLE "Purchases" ADD CONSTRAINT "Purchases_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Products"("productId") ON DELETE RESTRICT ON UPDATE CASCADE;
