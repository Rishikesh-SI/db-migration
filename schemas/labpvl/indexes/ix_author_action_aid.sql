-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_author_action_aid ON labpvl.labpvl_author_action USING btree (author_id);


--
