-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_author_action_aid ON labdv.labdv_author_action USING btree (author_id);


--
