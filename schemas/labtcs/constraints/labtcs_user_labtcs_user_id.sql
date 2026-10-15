-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_user labtcs_user_id
-- Type: CONSTRAINT

-- Name: labtcs_user labtcs_user_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_user
    ADD CONSTRAINT labtcs_user_id PRIMARY KEY (user_id);


--
