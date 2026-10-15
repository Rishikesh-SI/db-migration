-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_author_action_aid
-- Type: INDEX

-- Name: ix_pkl_author_action_aid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_author_action_aid ON labpkl.labpkl_author_action USING btree (author_id);


--
