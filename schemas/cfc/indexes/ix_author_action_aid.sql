-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_author_action_aid ON cfc.cfc_author_action USING btree (author_id);


--
