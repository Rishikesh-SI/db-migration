-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labetpl; Owner: -
--

CREATE INDEX ix_author_action_aid ON labetpl.labetpl_author_action USING btree (author_id);


--
