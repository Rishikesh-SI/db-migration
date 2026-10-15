-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_app_status mum_app_status_id
-- Type: CONSTRAINT

-- Name: tmmimg_upd_app_status mum_app_status_id; Type: CONSTRAINT; Schema: tmmimg_upd; Owner: -
--

ALTER TABLE ONLY tmmimg_upd.tmmimg_upd_app_status
    ADD CONSTRAINT mum_app_status_id PRIMARY KEY (app_id);


--
