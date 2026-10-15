-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_author_action_aid
-- Type: INDEX

-- Name: ix_hsl_author_action_aid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_author_action_aid ON labhsl.labhsl_author_action USING btree (author_id);


--
