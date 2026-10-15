-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labpr; Owner: -
--

CREATE INDEX ix_author_action_aid ON labpr.labpr_author_action USING btree (author_id);


--
