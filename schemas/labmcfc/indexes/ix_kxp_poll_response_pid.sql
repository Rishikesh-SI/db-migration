-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_kxp_poll_response_pid
-- Type: INDEX

-- Name: ix_kxp_poll_response_pid; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_kxp_poll_response_pid ON labmcfc.labmcfc_poll_response USING btree (poll_id);


--
