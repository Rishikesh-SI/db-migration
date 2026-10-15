-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_poll_response_pid
-- Type: INDEX

-- Name: ix_ttmum_poll_response_pid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_poll_response_pid ON labisp.labisp_poll_response USING btree (poll_id);


--
