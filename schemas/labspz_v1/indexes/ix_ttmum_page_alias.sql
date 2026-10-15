-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labspz_v1; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labspz_v1.labspz_v1_page USING btree (alias);


--
