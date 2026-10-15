-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_author_action_aid
-- Type: INDEX

-- Name: ix_tcs_author_action_aid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_author_action_aid ON tcs.tcs_author_action USING btree (author_id);


--
