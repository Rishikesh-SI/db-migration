-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX ix_author_action_aid ON labgt.labgt_author_action USING btree (author_id);


--
