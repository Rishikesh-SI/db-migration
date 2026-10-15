-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labtmum; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labtmum.labtmum_page USING btree (alias);


--
