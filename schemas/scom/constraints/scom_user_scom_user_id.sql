-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_user scom_user_id
-- Type: CONSTRAINT

-- Name: scom_user scom_user_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_user
    ADD CONSTRAINT scom_user_id PRIMARY KEY (user_id);


--
