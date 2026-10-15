-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labspz_v1; Owner: -
--

CREATE INDEX ix_author_action_aid ON labspz_v1.labspz_v1_author_action USING btree (author_id);


--
