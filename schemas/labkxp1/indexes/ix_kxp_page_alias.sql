-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_page_alias
-- Type: INDEX

-- Name: ix_kxp_page_alias; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_page_alias ON labkxp1.labkxp_page USING btree (alias);


--
