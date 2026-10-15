-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_app_status mum_app_status_id
-- Type: CONSTRAINT

-- Name: tmm_app_status mum_app_status_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_app_status
    ADD CONSTRAINT mum_app_status_id PRIMARY KEY (app_id);


--
