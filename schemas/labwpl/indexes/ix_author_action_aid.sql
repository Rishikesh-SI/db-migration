-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labwpl; Owner: -
--

CREATE INDEX ix_author_action_aid ON labwpl.labwpl_author_action USING btree (author_id);


--
