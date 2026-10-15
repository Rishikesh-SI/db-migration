-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labisl_v1.labisl_v1_page USING btree (alias);


--
