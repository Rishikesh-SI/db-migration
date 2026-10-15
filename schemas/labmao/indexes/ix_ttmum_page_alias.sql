-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labmao; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labmao.labmao_page USING btree (alias);


--
