-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labdsg; Owner: -
--

CREATE INDEX ix_author_action_aid ON labdsg.labdsg_author_action USING btree (author_id);


--
