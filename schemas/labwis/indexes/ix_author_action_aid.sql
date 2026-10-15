-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX ix_author_action_aid ON labwis.labwis_author_action USING btree (author_id);


--
