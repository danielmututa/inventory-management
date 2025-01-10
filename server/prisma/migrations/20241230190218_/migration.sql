/*
  Warnings:

  - You are about to drop the column `catagory` on the `ExpenseByCategory` table. All the data in the column will be lost.
  - You are about to drop the column `totalvalue` on the `SalesSummary` table. All the data in the column will be lost.
  - Added the required column `category` to the `ExpenseByCategory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `totalValue` to the `SalesSummary` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ExpenseByCategory" DROP COLUMN "catagory",
ADD COLUMN     "category" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "SalesSummary" DROP COLUMN "totalvalue",
ADD COLUMN     "totalValue" DOUBLE PRECISION NOT NULL;
