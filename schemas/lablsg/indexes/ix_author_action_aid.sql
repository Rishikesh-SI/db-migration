-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: lablsg; Owner: -
--

CREATE INDEX ix_author_action_aid ON lablsg.lablsg_author_action USING btree (author_id);


--
