-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_author_action_aid
-- Type: INDEX

-- Name: ix_jafc_author_action_aid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_author_action_aid ON jafc.jafc_author_action USING btree (author_id);


--
