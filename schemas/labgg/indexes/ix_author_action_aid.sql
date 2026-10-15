-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_author_action_aid ON labgg.labgg_author_action USING btree (author_id);


--
