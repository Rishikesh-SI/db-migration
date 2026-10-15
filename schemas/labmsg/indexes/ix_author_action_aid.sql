-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labmsg; Owner: -
--

CREATE INDEX ix_author_action_aid ON labmsg.labmsg_author_action USING btree (author_id);


--
