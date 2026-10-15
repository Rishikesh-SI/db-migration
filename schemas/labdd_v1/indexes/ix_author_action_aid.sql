-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX ix_author_action_aid ON labdd_v1.labdd_v1_author_action USING btree (author_id);


--
