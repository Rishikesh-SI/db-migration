-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_web_user labwf_web_user_mobile_no_key
-- Type: CONSTRAINT

-- Name: labwf_web_user labwf_web_user_mobile_no_key; Type: CONSTRAINT; Schema: fanxp_wf; Owner: -
--

ALTER TABLE ONLY fanxp_wf.labwf_web_user
    ADD CONSTRAINT labwf_web_user_mobile_no_key UNIQUE (mobile_no);


--
