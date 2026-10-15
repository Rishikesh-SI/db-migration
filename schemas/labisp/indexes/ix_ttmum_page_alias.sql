-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labisp.labisp_page USING btree (alias);


--
