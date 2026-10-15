-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labtkrold; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labtkrold.labtkr_page USING btree (alias);


--
