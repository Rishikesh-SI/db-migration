-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_author_action_aid ON labstmp.labstmp_author_action USING btree (author_id);


--
