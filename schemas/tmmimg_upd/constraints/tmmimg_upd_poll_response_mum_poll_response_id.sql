-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_poll_response mum_poll_response_id
-- Type: CONSTRAINT

-- Name: tmmimg_upd_poll_response mum_poll_response_id; Type: CONSTRAINT; Schema: tmmimg_upd; Owner: -
--

ALTER TABLE ONLY tmmimg_upd.tmmimg_upd_poll_response
    ADD CONSTRAINT mum_poll_response_id PRIMARY KEY (poll_response_id);


--
