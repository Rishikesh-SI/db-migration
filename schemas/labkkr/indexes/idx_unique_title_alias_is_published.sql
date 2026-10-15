-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: idx_unique_title_alias_is_published
-- Type: INDEX

-- Name: idx_unique_title_alias_is_published; Type: INDEX; Schema: labkkr; Owner: -
--

CREATE UNIQUE INDEX idx_unique_title_alias_is_published ON labkkr.labkkr_article USING btree (title_alias, is_published);


--
