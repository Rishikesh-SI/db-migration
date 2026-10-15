-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_pcpd_ug
-- Type: INDEX

-- Name: ix_pcpd_ug; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_pcpd_ug ON labmi.labmi_product_cart_paydetails USING btree (user_guid);


--
