-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_poll labtri_poll_id
-- Type: CONSTRAINT

-- Name: labtri_poll labtri_poll_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_poll
    ADD CONSTRAINT labtri_poll_id PRIMARY KEY (poll_id);


--
