-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labtkr_beta; Owner: -
--

CREATE INDEX ix_author_action_aid ON labtkr_beta.labtkr_author_action USING btree (author_id);


--
