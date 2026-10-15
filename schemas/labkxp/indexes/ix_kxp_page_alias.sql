-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_page_alias
-- Type: INDEX

-- Name: ix_kxp_page_alias; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_page_alias ON labkxp.labkxp_page USING btree (alias);


--
