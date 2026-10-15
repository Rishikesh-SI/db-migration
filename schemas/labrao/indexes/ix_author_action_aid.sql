-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labrao; Owner: -
--

CREATE INDEX ix_author_action_aid ON labrao.labrao_author_action USING btree (author_id);


--
