-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_site_partner_sid
-- Type: INDEX

-- Name: ix_scom_site_partner_sid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_site_partner_sid ON scom.scom_site_partner USING btree (site_id);


--
