-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: idx_unique_title_alias_is_publish
-- Type: INDEX

-- Name: idx_unique_title_alias_is_publish; Type: INDEX; Schema: labkkr_beta; Owner: -
--

CREATE UNIQUE INDEX idx_unique_title_alias_is_publish ON labkkr_beta.labkkr_album USING btree (title_alias, is_published);


--
