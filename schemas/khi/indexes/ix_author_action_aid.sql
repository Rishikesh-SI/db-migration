-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_author_action_aid ON khi.khi_author_action USING btree (author_id);


--
