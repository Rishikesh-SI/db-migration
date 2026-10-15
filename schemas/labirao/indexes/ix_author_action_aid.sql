-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labirao; Owner: -
--

CREATE INDEX ix_author_action_aid ON labirao.labirao_author_action USING btree (author_id);


--
