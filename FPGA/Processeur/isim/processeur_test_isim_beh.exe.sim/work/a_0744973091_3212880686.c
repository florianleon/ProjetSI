/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ddf5b5d */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/fleon/Bureau/ProjetSI/FPGA/BancRegistres/BR_module.vhd";
extern char *IEEE_P_3620187407;

unsigned char ieee_p_3620187407_sub_1306455576380142462_3965413181(char *, char *, char *, char *, char *);
int ieee_p_3620187407_sub_5109402382352621412_3965413181(char *, char *, char *);


static void work_a_0744973091_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    int t9;
    int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    unsigned char t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    unsigned char t25;
    char *t26;
    char *t27;
    unsigned char t28;
    unsigned char t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;

LAB0:    xsi_set_current_line(51, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 7272U);
    t3 = (t0 + 1352U);
    t4 = *((char **)t3);
    t3 = (t0 + 7304U);
    t5 = ieee_p_3620187407_sub_1306455576380142462_3965413181(IEEE_P_3620187407, t2, t1, t4, t3);
    if (t5 != 0)
        goto LAB3;

LAB4:    t21 = (t0 + 1032U);
    t22 = *((char **)t21);
    t21 = (t0 + 7272U);
    t23 = (t0 + 1352U);
    t24 = *((char **)t23);
    t23 = (t0 + 7304U);
    t25 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t22, t21, t24, t23);
    if (t25 == 1)
        goto LAB7;

LAB8:    t20 = (unsigned char)0;

LAB9:    if (t20 != 0)
        goto LAB5;

LAB6:
LAB2:    t35 = (t0 + 4440);
    *((int *)t35) = 1;

LAB1:    return;
LAB3:    t6 = (t0 + 2472U);
    t7 = *((char **)t6);
    t6 = (t0 + 1032U);
    t8 = *((char **)t6);
    t6 = (t0 + 7272U);
    t9 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t8, t6);
    t10 = (t9 - 0);
    t11 = (t10 * 1);
    xsi_vhdl_check_range_of_index(0, 15, 1, t9);
    t12 = (8U * t11);
    t13 = (0 + t12);
    t14 = (t7 + t13);
    t15 = (t0 + 4552);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t14, 8U);
    xsi_driver_first_trans_fast_port(t15);
    goto LAB2;

LAB5:    t26 = (t0 + 1672U);
    t30 = *((char **)t26);
    t26 = (t0 + 4552);
    t31 = (t26 + 56U);
    t32 = *((char **)t31);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    memcpy(t34, t30, 8U);
    xsi_driver_first_trans_fast_port(t26);
    goto LAB2;

LAB7:    t26 = (t0 + 1512U);
    t27 = *((char **)t26);
    t28 = *((unsigned char *)t27);
    t29 = (t28 == (unsigned char)3);
    t20 = t29;
    goto LAB9;

}

static void work_a_0744973091_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    int t9;
    int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    unsigned char t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    unsigned char t25;
    char *t26;
    char *t27;
    unsigned char t28;
    unsigned char t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;

LAB0:    xsi_set_current_line(53, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t1 = (t0 + 7288U);
    t3 = (t0 + 1352U);
    t4 = *((char **)t3);
    t3 = (t0 + 7304U);
    t5 = ieee_p_3620187407_sub_1306455576380142462_3965413181(IEEE_P_3620187407, t2, t1, t4, t3);
    if (t5 != 0)
        goto LAB3;

LAB4:    t21 = (t0 + 1192U);
    t22 = *((char **)t21);
    t21 = (t0 + 7288U);
    t23 = (t0 + 1352U);
    t24 = *((char **)t23);
    t23 = (t0 + 7304U);
    t25 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t22, t21, t24, t23);
    if (t25 == 1)
        goto LAB7;

LAB8:    t20 = (unsigned char)0;

LAB9:    if (t20 != 0)
        goto LAB5;

LAB6:
LAB2:    t35 = (t0 + 4456);
    *((int *)t35) = 1;

LAB1:    return;
LAB3:    t6 = (t0 + 2472U);
    t7 = *((char **)t6);
    t6 = (t0 + 1192U);
    t8 = *((char **)t6);
    t6 = (t0 + 7288U);
    t9 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t8, t6);
    t10 = (t9 - 0);
    t11 = (t10 * 1);
    xsi_vhdl_check_range_of_index(0, 15, 1, t9);
    t12 = (8U * t11);
    t13 = (0 + t12);
    t14 = (t7 + t13);
    t15 = (t0 + 4616);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t14, 8U);
    xsi_driver_first_trans_fast_port(t15);
    goto LAB2;

LAB5:    t26 = (t0 + 1672U);
    t30 = *((char **)t26);
    t26 = (t0 + 4616);
    t31 = (t26 + 56U);
    t32 = *((char **)t31);
    t33 = (t32 + 56U);
    t34 = *((char **)t33);
    memcpy(t34, t30, 8U);
    xsi_driver_first_trans_fast_port(t26);
    goto LAB2;

LAB7:    t26 = (t0 + 1512U);
    t27 = *((char **)t26);
    t28 = *((unsigned char *)t27);
    t29 = (t28 == (unsigned char)3);
    t20 = t29;
    goto LAB9;

}

static void work_a_0744973091_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    int t17;
    int t18;
    unsigned int t19;
    unsigned int t20;

LAB0:    t1 = (t0 + 4120U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(59, ng0);

LAB6:    t2 = (t0 + 4472);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    t6 = (t0 + 4472);
    *((int *)t6) = 0;
    xsi_set_current_line(61, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t5 = (t3 == (unsigned char)2);
    if (t5 != 0)
        goto LAB11;

LAB13:    xsi_set_current_line(64, ng0);
    t2 = (t0 + 1512U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t5 = (t3 == (unsigned char)3);
    if (t5 != 0)
        goto LAB16;

LAB18:
LAB17:
LAB12:    goto LAB2;

LAB5:    t4 = (t0 + 1952U);
    t5 = xsi_signal_has_event(t4);
    if (t5 == 1)
        goto LAB8;

LAB9:    t3 = (unsigned char)0;

LAB10:    if (t3 == 1)
        goto LAB4;
    else
        goto LAB6;

LAB7:    goto LAB5;

LAB8:    t6 = (t0 + 1992U);
    t7 = *((char **)t6);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)3);
    t3 = t9;
    goto LAB10;

LAB11:    xsi_set_current_line(62, ng0);
    t2 = xsi_get_transient_memory(128U);
    memset(t2, 0, 128U);
    t6 = t2;
    t7 = (t0 + 7559);
    t8 = (8U != 0);
    if (t8 == 1)
        goto LAB14;

LAB15:    t12 = (t0 + 4680);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t2, 128U);
    xsi_driver_first_trans_fast(t12);
    goto LAB12;

LAB14:    t11 = (128U / 8U);
    xsi_mem_set_data(t6, t7, 8U, t11);
    goto LAB15;

LAB16:    xsi_set_current_line(65, ng0);
    t2 = (t0 + 1672U);
    t6 = *((char **)t2);
    t2 = (t0 + 1352U);
    t7 = *((char **)t2);
    t2 = (t0 + 7304U);
    t17 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t7, t2);
    t18 = (t17 - 0);
    t11 = (t18 * 1);
    t19 = (8U * t11);
    t20 = (0U + t19);
    t10 = (t0 + 4680);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t6, 8U);
    xsi_driver_first_trans_delta(t10, t20, 8U, 0LL);
    goto LAB17;

}


extern void work_a_0744973091_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0744973091_3212880686_p_0,(void *)work_a_0744973091_3212880686_p_1,(void *)work_a_0744973091_3212880686_p_2};
	xsi_register_didat("work_a_0744973091_3212880686", "isim/processeur_test_isim_beh.exe.sim/work/a_0744973091_3212880686.didat");
	xsi_register_executes(pe);
}
