-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_author_action_aid ON dd.dd_author_action USING btree (author_id);


--
