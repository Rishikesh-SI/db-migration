-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_page_alias
-- Type: INDEX

-- Name: ix_scom_page_alias; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_page_alias ON scom.scom_page USING btree (alias);


--
