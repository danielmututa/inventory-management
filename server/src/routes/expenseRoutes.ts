import { Router } from "express";
import { getExpensesByCategory } from '../controllers/expenseController';


const expenseRoutes = Router();

expenseRoutes.get("/", getExpensesByCategory);

export default expenseRoutes;