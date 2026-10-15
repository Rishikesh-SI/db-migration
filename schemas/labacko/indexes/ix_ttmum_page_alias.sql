-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labacko; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labacko.labacko_page USING btree (alias);


--
