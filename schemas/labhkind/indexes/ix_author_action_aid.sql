-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labhkind; Owner: -
--

CREATE INDEX ix_author_action_aid ON labhkind.labhkind_author_action USING btree (author_id);


--
