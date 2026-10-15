-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_author_action_aid
-- Type: INDEX

-- Name: ix_author_action_aid; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_author_action_aid ON labmcfc.labmcfc_author_action USING btree (author_id);


--
