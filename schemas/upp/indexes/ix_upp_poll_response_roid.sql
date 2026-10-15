-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_poll_response_roid
-- Type: INDEX

-- Name: ix_upp_poll_response_roid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_poll_response_roid ON upp.upp_poll_response USING btree (response_option_id);


--
