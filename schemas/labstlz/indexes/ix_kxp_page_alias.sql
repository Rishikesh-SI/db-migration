-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_page_alias
-- Type: INDEX

-- Name: ix_kxp_page_alias; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_page_alias ON labstlz.labstlz_page USING btree (alias);


--
