-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX ix_author_action_aid ON labfih.labfih_author_action USING btree (author_id);


--
