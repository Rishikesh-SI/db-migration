-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: idx_unique_title_alias_is_published
-- Type: INDEX

-- Name: idx_unique_title_alias_is_published; Type: INDEX; Schema: labkkr_30012024; Owner: -
--

CREATE UNIQUE INDEX idx_unique_title_alias_is_published ON labkkr_30012024.labkkr_article USING btree (title_alias, is_published);


--
